Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267131AbSKSGaS>; Tue, 19 Nov 2002 01:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267132AbSKSGaS>; Tue, 19 Nov 2002 01:30:18 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5127 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267131AbSKSGaR>;
	Tue, 19 Nov 2002 01:30:17 -0500
Message-ID: <3DD9DBFF.5000009@pobox.com>
Date: Tue, 19 Nov 2002 01:36:47 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2/4 Module Parameter Support
References: <20021119062321.A48E12C48B@lists.samba.org>
In-Reply-To: <20021119062321.A48E12C48B@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Question for the crowd:

Should linux/module.h include moduleparam.h, since drivers are used to 
include'ing module.h to get all their MODULE_xxx desires fulfilled?

