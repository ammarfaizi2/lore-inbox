Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287303AbSACTdu>; Thu, 3 Jan 2002 14:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288258AbSACTdj>; Thu, 3 Jan 2002 14:33:39 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:19472 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S287303AbSACTdd>;
	Thu, 3 Jan 2002 14:33:33 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: R.Oehler@GDImbH.com
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jens Axboe <axboe@kernel.org>
Subject: Re: kernel 2.4.17 crashes on SCSI-errors 
In-Reply-To: Your message of "Thu, 03 Jan 2002 14:39:02 BST."
             <XFMail.20020103143902.R.Oehler@GDImbH.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 04 Jan 2002 06:33:12 +1100
Message-ID: <19996.1010086392@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Jan 2002 14:39:02 +0100 (MET), 
R.Oehler@GDImbH.com wrote:
>Ksymoops was not possible, because after rebooting the 
>memory/module-layout had changed. (Or is there a trick
>I don't know?)

/var/log/ksymoops.  man insmod, look for ksymoops assistance.

