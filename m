Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314451AbSDVS6y>; Mon, 22 Apr 2002 14:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314452AbSDVS6x>; Mon, 22 Apr 2002 14:58:53 -0400
Received: from panic.tn.gatech.edu ([130.207.137.62]:715 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S314451AbSDVS6w>;
	Mon, 22 Apr 2002 14:58:52 -0400
Date: Mon, 22 Apr 2002 14:58:50 -0400
From: Jeff Garzik <garzik@havoc.gtf.org>
To: "Jonathan A. George" <JGeorge@greshamstorage.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
Message-ID: <20020422145850.F11216@havoc.gtf.org>
In-Reply-To: <3CC4585F.4060005@greshamstorage.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2002 at 01:37:19PM -0500, Jonathan A. George wrote:
> The BK documentation constitutes an implicit advertisement and 
> endorsement of a product with a license which to many developers 
> violates the spirit of open source software.

Agreed.  

And the simple fact of Linus using BitKeeper does the
_exact_ _same_ _thing_.

Talk Linus out of using BitKeeper, and sure, I'll remove the doc.


> This is not to say that BK 
> is not an effective product, nor that the document in question is useful 
> for people who choose the tool, but to me it seems comparable to 
> including a closed source binary module in the kernel distribution. 

No, it is not comparable at all with that.  There are no license
problems with the document -- it is GPL'd.

It describes the same thing as Documentation/SubmittingPatches does, and
is very relevant to kernel development.


>  Moving the document to the BK website would be nicer, and would 
> certainly assauge bad feelings regarding such an integral implicit 
> endorsement of a tool.

Removing the doc from the kernel sources would be a token gesture only.

Some developers disagree violently with the use of non-open-source tools
at all, and that is a fundamental disagreement.

The majority of the "silently seething" developers, I imagine, are only
gonna be satisfied when (a) BitKeeper is GPL'd or (b) Linus stops using
BitKeeper.  Both of these seem very remote possibilities at present.

	Jeff


P.S.  The doc is _not_ going on the BK website by my hand.  (though I
have given BitMover permission to post the doc whereever they wish)
I can maintain my own docs much better than Larry can :)
