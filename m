Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132384AbRA3Vhn>; Tue, 30 Jan 2001 16:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132462AbRA3Vhd>; Tue, 30 Jan 2001 16:37:33 -0500
Received: from mailhost.teleline.es ([195.235.113.141]:9512 "EHLO
	tsmtp5.mail.isp") by vger.kernel.org with ESMTP id <S132384AbRA3VhU>;
	Tue, 30 Jan 2001 16:37:20 -0500
Message-ID: <3A7733F6.4070505@terra.es>
Date: Tue, 30 Jan 2001 22:36:54 +0100
From: Miguel Rodríguez Pérez <migrax@terra.es>
Reply-To: migras@atlas.uvigo.es
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1 i586; en-US; m18) Gecko/20001103
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Crash using DRI with 2.4.0 and 2.4.1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I have a Matrox G200 card installed on an Ali motherboard.
Sometimes when I use any opengl program my box crashes. It is more 
likely that it will crash if I have used the xvideo extension or the 
matroxfb, but this is not a must, it simply increases the chance of a 
crash, which is very high anyway.
I have tried both 2.4.0 and 2.4.1 kernels with Xfree 4.0.2 both with the 
same results.
Another problem I am having is that if I enable dri in X I can't see 
what I type in the fb.

Please, if someone reports to this, please include myself in the cc, as 
I am not suscribed to the list.

PD: excuse my horrible English, I write much better in Spanish ;-)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
