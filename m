Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbUARSAr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 13:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbUARSAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 13:00:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3788 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262164AbUARSAj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 13:00:39 -0500
Message-ID: <400AC9BA.1020103@pobox.com>
Date: Sun, 18 Jan 2004 13:00:26 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Witold Krecicki <adasi@kernel.pl>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: Serial ATA (SATA) for Linux status report
References: <20031203204445.GA26987@gtf.org> <200401181432.55736.adasi@kernel.pl>
In-Reply-To: <200401181432.55736.adasi@kernel.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Witold Krecicki wrote:
> Dnia Wednesday 03 of December 2003 21:44, Jeff Garzik napisa³:
> 
>>Editor's preface:  This is clearly a first draft, only covering the
>>basics.  In order for this document to be effective, I request that
>>users and developers send me (or post) their SATA driver questions and
>>issues.  I will do my best to address them here.
>>
>>
>>Serial ATA (SATA) for Linux
>>status report
>>Dec 3, 2003
> 
> What about SMART capabilities? with sii3112 I had it, but with libata I cannot 
> get any informations :/


Currently do not support random userland programs throwing random ATA 
commands at us...  so no SMART support at present :)  It's coming, though.

	Jeff



