Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129318AbRCPAiQ>; Thu, 15 Mar 2001 19:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129292AbRCPAiG>; Thu, 15 Mar 2001 19:38:06 -0500
Received: from gepetto.dc.luth.se ([130.240.42.40]:11991 "EHLO
	gepetto.dc.luth.se") by vger.kernel.org with ESMTP
	id <S129318AbRCPAh4>; Thu, 15 Mar 2001 19:37:56 -0500
Date: Fri, 16 Mar 2001 01:33:50 +0100
From: kozkir-8 <kozkir-8@student.luth.se>
X-Mailer: The Bat! (v1.49) UNREG / CD5BF9353B3B7091
Reply-To: kozkir-8 <kozkir-8@student.luth.se>
X-Priority: 3 (Normal)
Message-ID: <671081119.20010316013350@student.luth.se>
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re[4]: VIA686A chipset crash under 2.4.2-ac20
In-Reply-To: <Pine.LNX.4.10.10103151157400.28602-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.10.10103151157400.28602-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: MD5



>> >> kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
>>
>> MH> this can only be caused by bad cable/config.  is it 18", with both ends
>> MH> plugged in?
>>
>>
>> Do you mean 40-pin E-IDE cable?

MH> 40-conductor cables are only valid to use up to udma33, but 80c cables
MH> will *always* help, and can be used in any mode.  but equally important
MH> is that the cable must never be longer than 18", with both ends plugged in
MH> (no stub).

I measured the cable and it is aprox. 45cm (18") and it is 80c.
It has also 3 connectors, two of them are in use (on the ends), and
one is free (in the middle). I also checked the connections on
motherboard and on disk, they are both ok.

-----BEGIN PGP SIGNATURE-----
Version: 2.6

iQCVAwUAOrFfcT5SQymVx3NvAQEmwQP/bMQYXekwlUDKPdQ80khqfkv45TCY8lVd
r6lXb82s60vvbEpCTyF16E4TwQkwirsPf5virJ0jZO+EBFRVwOhDFitbaF9PdHhG
MdSFtST6JrhwozsoU3LgkdMZb3Mnnw7YsV9ctOZij+4WN5SDd5IO5YNXgeWgrdLb
c+jZzBpmLK8=
=PvVG
-----END PGP SIGNATURE-----


