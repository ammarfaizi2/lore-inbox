Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291400AbSBMGTf>; Wed, 13 Feb 2002 01:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291399AbSBMGTZ>; Wed, 13 Feb 2002 01:19:25 -0500
Received: from pizda.ninka.net ([216.101.162.242]:42122 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S291397AbSBMGTP>;
	Wed, 13 Feb 2002 01:19:15 -0500
Date: Tue, 12 Feb 2002 22:17:26 -0800 (PST)
Message-Id: <20020212.221726.34760851.davem@redhat.com>
To: raghuangadi@yahoo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: memory corruption in tcp bind hash buckets on SMP? 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020213060529.91301.qmail@web12305.mail.yahoo.com>
In-Reply-To: <20020213060529.91301.qmail@web12305.mail.yahoo.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This bug is fixed in the 2.4.9 Red Hat 7.2 errata kernels.
