Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274115AbRISRbT>; Wed, 19 Sep 2001 13:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274116AbRISRbJ>; Wed, 19 Sep 2001 13:31:09 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:14352 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S274115AbRISRbC>; Wed, 19 Sep 2001 13:31:02 -0400
Date: Wed, 19 Sep 2001 19:31:06 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: "Randy.Dunlap" <rddunlap@osdlab.org>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, crutcher+kernel@datastacks.com,
        lkml <linux-kernel@vger.kernel.org>, paulus@au.ibm.com
Subject: Re: Magic SysRq +# in 2.4.9-ac/2.4.10-pre12
Message-ID: <20010919193105.E7179@arthur.ubicom.tudelft.nl>
In-Reply-To: <3BA8C01D.79FBD7C3@osdlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BA8C01D.79FBD7C3@osdlab.org>; from rddunlap@osdlab.org on Wed, Sep 19, 2001 at 08:56:13AM -0700
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 08:56:13AM -0700, Randy.Dunlap wrote:
> I have an IBM model KB-9910 keyboard.  When I use
> Alt+SysRQ+number (number: 0...9) on it to change the
> console loglevel, only keys 5 and 6 have the desired
> effect.  I used showkey -s to view the scancodes from
> the other <number> keys, but showkey didn't display
> anything for them.  Any other suggestions?

Same over here with an IBM PS/2 keyboard that originally came with an
IBM PS2 model 55SX. The IBM keyboard is connected to an Asus M8300
laptop. The keyboard of that laptop has the interesting "feature" that
Alt-SysRQ-m sets the loglevel to 0, and Alt-SysRQ-[suob] also set the
loglevel to a different value instead of doing their job.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
