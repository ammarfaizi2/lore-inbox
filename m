Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290710AbSAYTkq>; Fri, 25 Jan 2002 14:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290625AbSAYTkg>; Fri, 25 Jan 2002 14:40:36 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46610 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S290513AbSAYTkS>;
	Fri, 25 Jan 2002 14:40:18 -0500
Message-ID: <3C51B49B.1E5AEEFE@mandrakesoft.com>
Date: Fri, 25 Jan 2002 14:40:11 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Momchil Velikov <velco@fadata.bg>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 64-bit divide tweaks
In-Reply-To: <87r8oez0ks.fsf@fadata.bg>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you are gonna hack them all anyway, why not turn them into static
inlines...
-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
