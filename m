Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290274AbSAOUQU>; Tue, 15 Jan 2002 15:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290273AbSAOUQN>; Tue, 15 Jan 2002 15:16:13 -0500
Received: from modemcable084.137-200-24.mtl.mc.videotron.ca ([24.200.137.84]:21148
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S290272AbSAOUPS>; Tue, 15 Jan 2002 15:15:18 -0500
Date: Tue, 15 Jan 2002 15:15:10 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: <nico@xanadu.home>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: lkml <linux-kernel@vger.kernel.org>, <kbuild-devel@lists.sourceforge.net>
Subject: Re: CML2-2.1.3 is available
In-Reply-To: <20020115145324.A5772@thyrsus.com>
Message-ID: <Pine.LNX.4.33.0201151514090.5892-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2002, Eric S. Raymond wrote:

> The latest version is always available at <http://www.tuxedo.org/~esr/cml2/>.
> 
> Release 2.1.3: Tue Jan 15 14:41:45 EST 2002
> 	* The `vitality' flag is gone from the language.  Instead, the 
> 	  autoprober detects the type of your root filesystem and forces
> 	  its symbol to Y.

What happens if you compile a kernel for another machine?  Or cross-compile?


Nicolas

