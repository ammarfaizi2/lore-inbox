Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261258AbTCTAg0>; Wed, 19 Mar 2003 19:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261264AbTCTAg0>; Wed, 19 Mar 2003 19:36:26 -0500
Received: from main.gmane.org ([80.91.224.249]:17841 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S261258AbTCTAgZ>;
	Wed, 19 Mar 2003 19:36:25 -0500
Mail-Followup-To: linux-kernel@vger.kernel.org
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Lars Magne Ingebrigtsen <larsi@gnus.org>
Subject: Re: How to Enable Hyper Threading?
Date: Thu, 20 Mar 2003 01:47:22 +0100
Organization: Programmerer Ingebrigtsen
Message-ID: <m3vfyedftx.fsf@quimbies.gnus.org>
References: <Pine.LNX.4.44.0303191706350.23957-100000@arnold.its.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@main.gmane.org
Mail-Copies-To: never
X-Now-Playing: Stars As Eyes's _Important Youth Movement_: "People Kill
 People"
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAHlBMVEXa2tqQkJBaWlr////9
 /f35+fnz8/M4ODgcHBwGBgaSXGOpAAACSUlEQVR4nF2Uv5LaMBCHl8nEteXm2tM2ojc8AXd5AfDV
 zCRWHdSs0rqR3KaJ/bb5rezDTjRDo0/772OB8qv3h8awBDbMbMgT4XMggPsLH445WVA2td77O9EE
 wLaJ42AAEkIUgGiE8DGPD9O4mEuI9x+e0isZDibnV9NIDgioKkR4ivXBucBRECDBljy+9z1le8iS
 gkvoCe/1ddd3Hz3FZA8xiUvMrrzvLm3bnjvK/KidRA4AdeX7W6vnBDCIyBBFkEnfvxXQfqMcRFxA
 fSe2WvLoORNyK5DBSe030FJGFgkuNMzPCgWkjBJZgjG26reAlkKUgWfYs7XvOkSs1Ukk2uMUjsHU
 Ohsk9WuEgsTHiYs9fBvVdY349RgBsnqir3fAfikecwJwf6whYzA7DGoPcJVzDvwyNDWhzO3d993b
 2wVz5IhmbcMA9OPSnn1/hcN3iuOUI1vH/OW09HNZ280pQaAl+/18bbdDguJQbnXwy38AKwXnCk57
 V9qrg0cd3HdPgq5+M+6TVVC93y7PVACMAC7AX7cakGslNEuqflc8BMuOjw8Fu75IWIxpjNNNgI3b
 LkIsLBlLRflzGGLspzFllbH7lf/oP4FeG0OlJ+9v7elZoxDqfTndVgNeYcqsa77NEfTXx8365f3T
 rhrkpczOO6lZdFbA3jvpPY+zxtBWurjCys3zPMEv7Zc6xRjzrGeyGHObHO8/waAGVnKicZw/T7ZL
 C3fqscLzdqZHcUANqlV7MD/MYqHBuv4P4Fr/ZmhJNa3gJ5VUutz0F6J0OY86cghFAAAAAElFTkSu
 QmCC
User-Agent: Gnus/5.090017 (Oort Gnus v0.17) Emacs/21.3.50 (gnu/linux)
Cancel-Lock: sha1:Ry3bxqsXuW7UkSHYLaAROktxZJY=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terrence Martin <twm139@its.to> writes:

> Intel E7205 Chipset Asus P4G8X Motherboard (533Mhz FSB)

[...]

> /proc/cpuinfo only reports a single CPU as does top. 

I had similar problems with a different Asus P4 (i850) motherboard.
After I applied the ACPI patches from
<URL: http://sourceforge.net/projects/acpi>, everything started
working as it should.

-- 
(domestic pets only, the antidote for overdose, milk.)
   larsi@gnus.org * Lars Magne Ingebrigtsen

