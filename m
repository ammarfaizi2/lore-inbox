Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290312AbSAPAx5>; Tue, 15 Jan 2002 19:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289804AbSAPAxu>; Tue, 15 Jan 2002 19:53:50 -0500
Received: from ns1.baby-dragons.com ([199.33.245.254]:3974 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S290312AbSAPAxE>; Tue, 15 Jan 2002 19:53:04 -0500
Date: Tue, 15 Jan 2002 19:51:44 -0500 (EST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Wakko Warner <wakko@animx.eu.org>
cc: "J.A. Magallon" <jamagallon@able.es>, <linux-kernel@vger.kernel.org>
Subject: Re: Unable to compile 2.4.14 on alpha
In-Reply-To: <20020115190344.A20283@animx.eu.org>
Message-ID: <Pine.LNX.4.44.0201151926580.9754-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Wakko ,

On Tue, 15 Jan 2002, Wakko Warner wrote:
 ...snip...
> just out of curiosity, I have this dac960 controller with alpha 2.70
> firmware.  I know it says it needs 2.73, but the latest for alpha is 2.70.
> Any ideas if it'll work or not?
	Nope ,  The linux DAC960 driver needs 3.51-0-04 for dual flash .
	Or 2.73-0-00 for single flash .  And beleive me Leonard means what
	he put in the README.DAC960 file .
	2.73 usability is new to me as when one of these dropped into my
	hands all the driver supported was the Dual 3.51... firmware .
	Using either of the above will work on Linux ,  BUT not alpha
	vms/osf/nt .
	The cost for the items from Mylex isn't reasonable imo .  But if
	you want it & have a flash burner , Get two just like on the card
	now & download the firmware & burn it .  Don't get the XDBA
	version as IIRC the alpha boards don't support it .  But do check
	if MB you have does .  Might get lucky .

> If I loose the contents of everything on this sytem, fine, I have another
> disk with the system on it so I won't loose anything.  =)

>  Lab tests show that use of micro$oft causes cancer in lab animals
	And other living things !-)  Hth ,  JimL

       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+

