Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131368AbRACQ6I>; Wed, 3 Jan 2001 11:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131998AbRACQ56>; Wed, 3 Jan 2001 11:57:58 -0500
Received: from smtp1.mail.yahoo.com ([128.11.69.60]:20741 "HELO
	smtp1.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S131368AbRACQ5u>; Wed, 3 Jan 2001 11:57:50 -0500
X-Apparently-From: <quintaq@yahoo.co.uk>
Date: Wed, 3 Jan 2001 16:28:16 +0000
From: quintaq@yahoo.co.uk
To: linux-kernel@vger.kernel.org
Subject: Re: Fw: UDMA on 815e chipset
In-Reply-To: <3A5337EB.56172C60@windsormachine.com>
In-Reply-To: <20010103121218Z130812-439+8159@vger.kernel.org>
	<3A5337EB.56172C60@windsormachine.com>
Reply-To: quintaq@yahoo.co.uk
X-Mailer: Sylpheed version 0.4.9 (GTK+ 1.2.8; Linux 2.2.16; i686)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20010103165751Z131368-439+8222@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike / Mark,

Thank-you very much for your replies.

With regard to Mike, (a) I am using a PIII 800, so I really should be seeing better results than your Celeron.  It seems, therefore, that my setup may be defective in more fundamental ways than I had imagined.  (b) I do appreciate that I may not see any real benefit from Ultra/66 at this stage - I was just keen to experiment and see that the hardware was working.

In reply to Mark : (a) my HDD was certainly sold as UDMA 5 capable, and hdparm reports that it is.  (b) I do not think you meant to suggest that I would solve the problem by deleting the -c and -m switches, but I deleted them anyway and the problem remains. (c) I wish I knew why the hell SuSE would include an obsolete kernel in their relatively new, flagship, v7 "Professional".  So far as I can see, kernel 2.4 is not even an option on their ftp site.  I use this machine for my business and cannot afford a major crash precipitated by a piece of inept kernel-tinkering on my part.

I do have a spare machine (bx board though),and I suppose that the way ahead is to play around installing the current kernel on that until I have the confidence to put it in this box.

One final thought.  When I installed the OS I was offered the option to "use DMA", which I accepted. I see this set at an early stage in the boot-process (long before my boot.local executes).  Is there any way this could be obstructing the subsequent instruction to use UDMA ?

Thanks again,

Geoff

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
