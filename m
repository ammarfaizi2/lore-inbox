Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275381AbRJFReN>; Sat, 6 Oct 2001 13:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275354AbRJFReD>; Sat, 6 Oct 2001 13:34:03 -0400
Received: from smtp3.cern.ch ([137.138.131.164]:30893 "EHLO smtp3.cern.ch")
	by vger.kernel.org with ESMTP id <S275336AbRJFRdz>;
	Sat, 6 Oct 2001 13:33:55 -0400
To: kernel@ddx.a2000.nu
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        <sparclinux@vger.kernel.org>
Subject: Re: sun + gigabit nic
In-Reply-To: <Pine.LNX.4.40.0110061551050.11144-100000@ddx.a2000.nu>
From: Jes Sorensen <jes@sunsite.dk>
Date: 06 Oct 2001 19:34:12 +0200
In-Reply-To: kernel@ddx.a2000.nu's message of "Sat, 6 Oct 2001 16:05:59 +0200 (CEST)"
Message-ID: <d3669su0yz.fsf@lxplus014.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "kernel" == kernel  <kernel@ddx.a2000.nu> writes:

kernel> On Fri, 5 Oct 2001, David S. Miller wrote:

>> No patches needed, 2.2.x (and 2.4.x) supports Syskonnect gigabit
>> cards out of the box.
>> 
>> Acenic is supported in 2.4.x, although I don't know why not in
>> 2.2.x as that should be trivial to make work...

kernel> so the Syskonnect SK-9D21 is supported ?

kernel> what about 3com and intel 1000base-t cards ? (which are much
kernel> lower priced compared to syskonnect)

3Com 3C985 series is supported by the AceNIC driver. The Intel cards
are only supported by an Intel provided driver which has license and
patent issues afaik.

kernel> also where can i found more info about Acenic ?
kernel> (www.Acenic.com doesn't work)

http://home.cern.ch/~jes/gige/acenic.html

AceNIC basically covers the following cards: Alteon AceNIC, 3Com
3C985(B), NetGear GA620(T) and some cards from Farallon, DEC, HP & SGI
which I do not remember the model numbers of.

Jes
