Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316538AbSEPBop>; Wed, 15 May 2002 21:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316539AbSEPBoo>; Wed, 15 May 2002 21:44:44 -0400
Received: from ns.suse.de ([213.95.15.193]:31240 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S316538AbSEPBon>;
	Wed, 15 May 2002 21:44:43 -0400
Date: Thu, 16 May 2002 03:44:42 +0200
From: Dave Jones <davej@suse.de>
To: John Levon <movement@marcelothewonderpenguin.com>
Cc: Rob Landley <landley@trommello.org>, John Weber <john.weber@linuxhq.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [OT] Unofficial but Supported Kernel Patches
Message-ID: <20020516034442.C21902@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	John Levon <movement@marcelothewonderpenguin.com>,
	Rob Landley <landley@trommello.org>,
	John Weber <john.weber@linuxhq.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L2.0205121935000.18593-100000@dragon.pdx.osdl.net> <3CDF2C7C.7090203@linuxhq.com> <20020515200758.BEAB373B@merlin.webofficenow.com> <20020515205607.GA19388@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2002 at 09:56:08PM +0100, John Levon wrote:
 > On Wed, May 15, 2002 at 09:43:26AM -0400, Rob Landley wrote:
 > 
 > > it's way better than nothing.)  There's buildable docbook documentation in 
 > > the source tarball that in theory could be blasted to HTML and posted online, 
 > > and that might be nice to have a standard location for.  (If there is one 
 > > already, I missed it.)
 > 
 > http://kernelnewbies.org/documents/

The pdf's there are somewhat up to date, the html version has fallen
behind quite a bit due to lack of time on my part. Christoph Hellwig
offered to update that, but I believe he's also been quite busy of
late.

In theory it could be mostly automated. The only reason I didn't do it
already was every time I updated it so far, the names of the html
files changed, which meant lots of manual 'cvs add' & 'cvs remove'
operations to kernelnewbies CVS.

iirc, Christoph had a workaround for this problem..

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
