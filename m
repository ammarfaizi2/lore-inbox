Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318798AbSG0SMI>; Sat, 27 Jul 2002 14:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318799AbSG0SMI>; Sat, 27 Jul 2002 14:12:08 -0400
Received: from 60.54.252.64.snet.net ([64.252.54.60]:53839 "EHLO
	mail.blue-labs.org") by vger.kernel.org with ESMTP
	id <S318798AbSG0SMH>; Sat, 27 Jul 2002 14:12:07 -0400
Message-ID: <3D42E333.4010602@blue-labs.org>
Date: Sat, 27 Jul 2002 14:15:15 -0400
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020726
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net
Subject: Linux booting from USB HD / USB interface devices
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Bmilter: Processing completed, Bmilter version 0.1.0 build 762; timestamp 2002-07-27 14:15:17, message serial number 165588
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux booting from USB HD

I've been doing some research in this area.  There are a few 
motherboards that I've come across that are capable of booting from a 
USB hard drive and I'm interested in collecting a lot of opinions and 
"yeah, i've done that" comments.  The end application for this is to 
mount a motherboard in a 4x4 truck to process dash data and sensory 
input (i.e. GPS, atmospheric, fire department data, etc), provide 
digitized maps (GIS), network connectivity via wireless, and be the 
radio/mp3/cd player etc.

The most promising vendor I've found so far is Gigabyte, one of the 
better motherboards appears to be the GA-8IGX model.

_Please note_, I'm specifically trying to use a USB harddrive, not a 
floppy.  I want the smallest number of devices required to run the 
system and floppy media is just too unreliable.  I'm also intending on 
putting the harddrive several feet away from the motherboard -- the 
system's physical profile has to be flexible.

1) Most motherboard vendors (that mention Linux) are indicating Linux 
2.4.x for support.  How is the USB Mass storage support in 2.4.19+?
2) There are some vague comments about some devices requiring the 
ability to boot, are there some USB hard drives that are incapable of 
acting as a boot device?
3) I don't suspect there is anything tricky or nonstandard that I'd need 
to do on the USB drive, do I need corrected?
4) What kind of USB hard drives are well supported in Linux?
5) What kernel issues do I need to be aware of?



USB Interface devices

As part of the above project, I'd like to build a digital dash, full 
bidirection data flow.  Sensor data into computer, control data out. 
 I.e. read fuel, oil, speed, engine computer data, etc as sensory inputs 
and for output send data to control regular lighting, special lighting, 
fans, etc.  I'm really lacking in research results here, -any- feedback 
for this would be appreciated.



Comments or answers appreciated.  I promise to put up a web page with 
all the gadget details as I go along.

David

-- 
I may have the information you need and I may choose only HTML.  It's up to
you. Disclaimer: I am not responsible for any email that you send me nor am
I bound to any obligation to deal with any received email in any given
fashion.  If you send me spam or a virus, I may in whole or part send you
50,000 return copies of it. I may also publically announce any and all
emails and post them to message boards, news sites, and even parody sites. 
I may also mark them up, cut and paste, print, and staple them to telephone
poles for the enjoyment of people without internet access.  This is not a
confidential medium and your assumption that your email can or will be
handled confidentially is akin to baring your backside, burying your head in
the ground, and thinking nobody can see you butt nekkid and in plain view
for miles away.  Don't be a cluebert, buy one from K-mart today.


