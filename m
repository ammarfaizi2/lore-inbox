Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261284AbRELQxt>; Sat, 12 May 2001 12:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261285AbRELQxk>; Sat, 12 May 2001 12:53:40 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:24080 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S261284AbRELQx2>; Sat, 12 May 2001 12:53:28 -0400
Date: Sat, 12 May 2001 18:50:37 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Akos Maroy <darkeye@tyrell.hu>
Cc: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Process accessing a Sony DSC-F505V camera through USB as a storage device hangs.
Message-ID: <20010512185037.F8826@arthur.ubicom.tudelft.nl>
In-Reply-To: <3AFD2E41.213CFB47@tyrell.hu> <20010512151803.C8826@arthur.ubicom.tudelft.nl> <3AFD5C66.1CED33FB@tyrell.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AFD5C66.1CED33FB@tyrell.hu>; from darkeye@tyrell.hu on Sat, May 12, 2001 at 06:53:10PM +0300
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 12, 2001 at 06:53:10PM +0300, Akos Maroy wrote:
> Erik Mouw wrote:
> > 
> > On Sat, May 12, 2001 at 03:36:17PM +0300, Akos Maroy wrote:
> > > [1.] One line summary of the problem:
> > >
> > > Process accessing a Sony DSC-F505V camera through USB as a storage
> > > device hangs.
> 
> Additional information to this issue: kernel 2.4.3 works fine on the
> same machine, with the same kernel compilation settings.

Hmm. Not that I am a USB expert, but could you try it with the usb-uhci
driver? The uhci driver got quite some changes in 2.4.4, so it might be
related with those changes.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
