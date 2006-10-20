Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbWJTMdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbWJTMdi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 08:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751671AbWJTMdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 08:33:38 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:31920 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751663AbWJTMdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 08:33:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=dJmDoJW4pkJdWenGfIDB5lYF16LJhMYaSpXVY5ysssqah0PhefkceWGEBrzgDVTyL7CKbfZtEPn1SYylHrvlBMC2TAhIJ522vlPdnlYi6DK4RhjZnjhuiFpAE/5x27eqNoketPBsfPDbTOLBuwpLBU2JfWtWTcPdblahfesiotk=
Message-ID: <4538C228.9020109@googlemail.com>
Date: Fri, 20 Oct 2006 14:33:44 +0200
From: Gabriel C <nix.or.die@googlemail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060915)
MIME-Version: 1.0
To: Jiri Kosina <jikos@jikos.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc2-mm2
References: <20061020015641.b4ed72e5.akpm@osdl.org> <4538BA2E.9040808@googlemail.com> <Pine.LNX.4.64.0610201403090.29022@twin.jikos.cz>
In-Reply-To: <Pine.LNX.4.64.0610201403090.29022@twin.jikos.cz>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Kosina wrote:
> On Fri, 20 Oct 2006, Gabriel C wrote:
>
>   
>> I got this on ' make silentoldconfig '
>> drivers/media/dvb/dvb-usb/Kconfig:72:warning: 'select' used by config
>> symbol 'DVB_USB_DIB0700' refer to undefined symbol 'DVB_DIB7000M'
>>     
>
> This is not a new warning, and should already be fixed for some two weeks 
> or so in the v4l-dvb tree.
>
>   

Then sorry , for me was a new one I didn't notice it befor.


Gabriel
