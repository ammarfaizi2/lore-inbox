Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267552AbUIFHdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267552AbUIFHdA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 03:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267554AbUIFHdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 03:33:00 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:47319
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S267552AbUIFHc4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 03:32:56 -0400
Message-ID: <413C12A6.80909@bio.ifi.lmu.de>
Date: Mon, 06 Sep 2004 09:32:54 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.8.1-mm1][input] - IBM TouchPad support added? Which patch
 is this? - Unsure still
References: <200408170349.44626.shawn.starr@rogers.com> <200408170801.00068.dtor_core@ameritech.net> <41381972.8080600@bio.ifi.lmu.de> <200409030227.42441.dtor_core@ameritech.net> <413822F1.5060406@bio.ifi.lmu.de>
In-Reply-To: <413822F1.5060406@bio.ifi.lmu.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Steiner wrote:

>> But have you tried installing XFree86/XOrg Synaptics driver
>> (http://w1.894.telia.com/~u89404340/touchpad/index.html)?
>> It does support tapping just fine...

Yes, that works, as well as the gpm version I have (I just had to
detect the evdev option :-)).

And I also had success with the psmouse.proto=bare option which I just
checked to see if it works...

cu,
Frank

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049
* Rekursion kann man erst verstehen, wenn man Rekursion verstanden hat. *
