Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311483AbSDNAMC>; Sat, 13 Apr 2002 20:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311523AbSDNAMB>; Sat, 13 Apr 2002 20:12:01 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:36880 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S311483AbSDNAMA>;
	Sat, 13 Apr 2002 20:12:00 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: spyro@armlinux.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb-uhci *BUG* 
In-Reply-To: Your message of "Sun, 14 Apr 2002 00:40:22 +0100."
             <20020414004022.6450f038.spyro@armlinux.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 14 Apr 2002 10:11:48 +1000
Message-ID: <32607.1018743108@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Apr 2002 00:40:22 +0100, 
Ian Molton <spyro@armlinux.org> wrote:
>the backtrace /does/ seem to be the same every time. I dont have ksymoops
>(on ARM I decode oopses with grep and system.map :).

Any particular reason for not using ksymoops?  If it does not work on
arm, I can get rid of all the arm code ;).

