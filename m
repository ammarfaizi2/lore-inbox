Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131818AbRCOTzX>; Thu, 15 Mar 2001 14:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131819AbRCOTzN>; Thu, 15 Mar 2001 14:55:13 -0500
Received: from robur.slu.se ([130.238.98.12]:32785 "EHLO robur.slu.se")
	by vger.kernel.org with ESMTP id <S131818AbRCOTzE>;
	Thu, 15 Mar 2001 14:55:04 -0500
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15025.7653.808956.553263@robur.slu.se>
Date: Thu, 15 Mar 2001 20:54:13 +0100 (CET)
To: Jonathan Morton <chromi@cyberspace.org>
Cc: Robert Olsson <Robert.Olsson@data.slu.se>, hadi@cyberus.ca,
        linux-kernel@vger.kernel.org
Subject: Re: How to optimize routing performance
In-Reply-To: <l0313030eb6d6c75fcbf8@[192.168.239.101]>
In-Reply-To: <Pine.LNX.4.33.0103152137240.1320-100000@duckman.distro.conectiva>
	<15024.53099.41814.716733@robur.slu.se>
	<l0313030eb6d6c75fcbf8@[192.168.239.101]>
X-Mailer: VM 6.75 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jonathan Morton writes:

 > Nice.  Any chance of similar functionality finding its' way outside the
 > Tulip driver, eg. to 3c509 or via-rhine?  I'd find those useful, since one
 > or two of my Macs appear to be capable of generating pseudo-DoS levels of
 > traffic under certain circumstances which totally lock a 486 (for the
 > duration) and heavily load a P166 - even though said Macs "only" have
 > 10baseT Ethernet.

 I'm not the one to tell. :-) 

 First its kind of experimental. Jamal has talked about putting together 
 a proposal for enhancing RX-process for inclusion in the 2.5 kernels. 
 There is meeting soon for this.


 But why not experiment a bit?

 Cheers.

						--ro
