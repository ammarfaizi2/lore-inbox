Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315439AbSEUTAO>; Tue, 21 May 2002 15:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315445AbSEUTAN>; Tue, 21 May 2002 15:00:13 -0400
Received: from ns.suse.de ([213.95.15.193]:18696 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S315439AbSEUTAM>;
	Tue, 21 May 2002 15:00:12 -0400
Date: Tue, 21 May 2002 21:00:11 +0200
From: Dave Jones <davej@suse.de>
To: "Peter J. Braam" <braam@clusterfs.com>
Cc: Bob_Tracy <rct@gherkin.frus.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.X: intermezzo compile errors
Message-ID: <20020521210011.H15417@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	"Peter J. Braam" <braam@clusterfs.com>,
	Bob_Tracy <rct@gherkin.frus.com>, linux-kernel@vger.kernel.org
In-Reply-To: <m17AApp-0005khC@gherkin.frus.com> <20020521124459.N24085@lustre.cfs>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2002 at 12:44:59PM -0600, Peter J. Braam wrote:
 > Hi, 
 > 
 > Clearly we need to do something about this.  Apologies for the
 > problems. 

Hi Peter,
 There are a bunch of fixes in my tree that have been either
 brought forward from 2.4, or have been submitted by janitors at
 some point. You may find that patch useful to begin with.

 If you just want the intermezzo specific bits, let me know
 off list and I'll cut it up into bits.

 (I'd rather shove this your way now than have to resync these fixes
  after whatever you're about to do. I don't want a repeat of what
  happened with reiserfs in my tree circa 2.5.3 8-)

    Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
