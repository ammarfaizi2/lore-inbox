Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268296AbTBYVXq>; Tue, 25 Feb 2003 16:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268385AbTBYVXq>; Tue, 25 Feb 2003 16:23:46 -0500
Received: from services.erkkila.org ([24.97.94.217]:63893 "EHLO erkkila.org")
	by vger.kernel.org with ESMTP id <S268296AbTBYVXo>;
	Tue, 25 Feb 2003 16:23:44 -0500
Message-ID: <3E5BE146.4050308@erkkila.org>
Date: Tue, 25 Feb 2003 21:33:58 +0000
From: "Paul E. Erkkila" <pee@erkkila.org>
Reply-To: pee@erkkila.org
Organization: ErkkilaDotOrg
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030218
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Thinkpad Keyboard nuttiness since 2.5.60 with power managemen
 t
References: <F760B14C9561B941B89469F59BA3A8471380CA@orsmsx401.jf.intel.com>
In-Reply-To: <F760B14C9561B941B89469F59BA3A8471380CA@orsmsx401.jf.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    I have the same problems with repeating keys when
running under battery vs AC power with the later 2.5.6x
kernels on an IBM T20. It goes away when i plug in
the AC adaptor or boot w/o acpi. The only other oddity
i've noticed is that i have to cntrl-alt-del TWICE
to get it to reboot, the first one does jack, but
i'm not blaming that on the kernel just yet ;p

-pee

Grover, Andrew wrote:

>>From: daveman@bellatlantic.net [mailto:daveman@bellatlantic.net] 
>>I am seeing a strange keyboard related issue as well on a 
>>Thinkpad A20M. It seems if I walk away for say, 20 minutes, 
>>come back and try to input a password to KDE's screen saver, 
>>the FIRST keystroke I make is not recognized at all. All 
>>keystrokes after the first one register perfectly fine. This 
>>is on the laptop's built-in keyboard. I too am using ACPI. If 
>>I don't wait long enough it doesn't happen, so I do believe 
>>it has something to do with power management. I first noticed 
>>it in 2.5.61(first 2.5 kernel that would boot for me) and am 
>>currently running 2.5.63, where I still see it. I am not 
>>using modules.
>>
>>If anyone would like more info on this, please let me know.
>>    
>>
>
>I am seeing the same behavior under Windows on an IBM T20. This makes me
>think it is not something the kernel is to blame for.
>
>Regards -- Andy
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>

