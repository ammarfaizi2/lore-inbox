Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317123AbSEXLhD>; Fri, 24 May 2002 07:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317126AbSEXLhD>; Fri, 24 May 2002 07:37:03 -0400
Received: from schwerin.p4.net ([195.98.200.5]:32584 "EHLO schwerin.p4.net")
	by vger.kernel.org with ESMTP id <S317123AbSEXLhB>;
	Fri, 24 May 2002 07:37:01 -0400
Message-ID: <3CEE2670.4010701@p4all.de>
Date: Fri, 24 May 2002 13:39:28 +0200
From: Michael Dunsky <michael.dunsky@p4all.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: "Nix N. Nix" <nix@go-nix.ca>
Subject: Re: Reset PCI card
In-Reply-To: <1022145683.21661.15.camel@tux>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The "svgalib" has a tool named "reset_vga". It completely resets your
VGA-card . You may try it... but it's only a workaround at the cause and 
not at the symptom.

I used it a longer time ago with a similar problem (only slightly 
similar - programmed the VGA-card "by hand", and needed to clear the 
scrambled output I produced :-) ).

ciao

Michael


Nix N. Nix wrote:
 > The symptom:
 >
 > Sometimes, when I switch between virtual terminals, (away from X ==
 > tty7), instead of getting my usual login prompt, the picture I've had
 > during my X session (or the picture of the display manager) stays on
 > the screen, albeit with some of the colours screwed up (as if it were
 > a 256 colour palette-based display, even though it's 24 bit colour -
 > you know, like in Windows, when you have 256 colours and you switch
 > from one app to another and the colours in your background picture get
 > all frelled up).  The terminal does switch over to the appropriate tty
 > because I can log in and type whatever (blindly though) and it does
 > work.
 >



