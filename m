Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264617AbTASKbn>; Sun, 19 Jan 2003 05:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264907AbTASKbn>; Sun, 19 Jan 2003 05:31:43 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:53911 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S264617AbTASKbm>;
	Sun, 19 Jan 2003 05:31:42 -0500
Message-ID: <3E2A805D.2010104@colorfullife.com>
Date: Sun, 19 Jan 2003 11:39:25 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Florent CHANTRET <florent@chantret.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [INTEL PII BUG] Still SMBALERT# spontaneous shutdown on VAIO
 Serie F
References: <3E29C3E4.4010304@colorfullife.com> <006f01c2bfa0$06b51b00$0eb63851@vaio>
In-Reply-To: <006f01c2bfa0$06b51b00$0eb63851@vaio>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florent CHANTRET wrote:

>Hi,
>
>I've already updated my bios to the last revision but Sony give a poor
>support to those customers. I won't buy a VAIO anymore !
>
>As I've read on the website spokin' about VAIO problems, the problem seems
>to be connected to that, but yes, why not, it could be the SMI handler too.
>I only know that the sotware could solve it antd that's one of the several
>power of Linux other Windows.
>  
>
Which kernel do you use, and could you try to enable ACPI?
If it doesn't help, try the latest acpi patch from 
http://sourceforge.net/projects/acpi/

--
    Manfred

