Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264943AbUAOLds (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 06:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264966AbUAOLds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 06:33:48 -0500
Received: from relay-4.cs.interbusiness.it ([151.99.250.83]:25267 "EHLO
	antilope.cs.interbusiness.it") by vger.kernel.org with ESMTP
	id S264943AbUAOLdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 06:33:45 -0500
From: "Andrea Pusceddu" <a.pusceddu@remosa-valves.com>
Organization: Remosa SpA | www.remosa-valves.com
To: linux-kernel@vger.kernel.org
Date: Thu, 15 Jan 2004 12:30:47 +0100
MIME-Version: 1.0
Subject: Re: [USB-STORAGE] Repeatable lost files problem
Reply-to: callmeishmael@tiscali.it
Message-ID: <400687F7.20318.60C885D@localhost>
In-reply-to: <20040114195507.GA1533@one-eyed-alien.net>
References: <40051640.20530.684C08@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[....]  
> I'm guessing that the player is attempting to perform 
> some sort of special test on the data.  If the file doesn't conform, or if 
> the filesystem is 'different' in some way, it obliterates the offending 
> material. 
[....] 

Dear Matthew,  

thank you for your reply. One thing I really can't understand is HOW can a file copied  
from linux be different from the same file copied from Windows,  once it has been  
"wrote" into same the usb drive; it's really odd, isn't it? It seems kind of FUD to  
discourage Linux users :) 

If we were able to find out that difference it could be possible to "emulate" the way  
windows flags the copied files (just guessing, I'm not a kernel hacker..) 
If you believe that this odd behavior is worth a further investigation, I'm available for  
your tests, I could run diagnostic tools,  try out new drivers, and so on. 

The MP3 player supports the firmware upgrading, but in the producer web site that  
particular device is not listed. 
It's annoying, honestly only Windows support was mentioned in the player handbook so  
I knew  I could meet problems with my Debian box, but once I saw the chipset was  
supported, and I mounted in on /dev/sda, and I downloaded my data from it...  :) 

Do you think that it's worth  to try out with the 2.6 Kernel, or there aren't any important  
changes related to usb-storage that may help?  

Thank you again for the great work you are doing with usb-storage, and for the time you  
spent reading my messages. 

Best Regards,  
Andrea 
