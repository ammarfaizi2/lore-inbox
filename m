Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130781AbRAWPJj>; Tue, 23 Jan 2001 10:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131008AbRAWPJb>; Tue, 23 Jan 2001 10:09:31 -0500
Received: from h56s242a129n47.user.nortelnetworks.com ([47.129.242.56]:48010
	"EHLO zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S130781AbRAWPJY>; Tue, 23 Jan 2001 10:09:24 -0500
Message-ID: <28560036253BD41191A10000F8BCBD116BDCCB@zcard00g.ca.nortel.com>
From: "Jonathan Earle" <jearle@nortelnetworks.com>
To: "'Linux Kernel List'" <linux-kernel@vger.kernel.org>
Subject: RE: Coding Style
Date: Tue, 23 Jan 2001 10:07:10 -0500
X-Mailer: Internet Mail Service (5.5.2652.35)
X-Orig: <jearle@americasm01.nt.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: adrian
> 
> On Mon, 22 Jan 2001, Mark I Manning IV wrote:
> 
> > It is alot neater tho :P~
> >
> > // even for multi line comments
> > // no visual clutter over there -->
> 
> /*
>  * I tend to find standard C comments easier to read.  They stand out,
>  * especially for multiple lines (although I always try to put the :end:
>  * on a separate line for clarity).
>  */

I like this style for multiple line comments, but prefer the '//' for single
liners.  Two less characters to type after all.  :)
 
> int function(int x)
> {
> 	/* Bleh.  Comments take up space.
> 	 */
> 	function body;
> }

int function(int x) {
 	// I like comments.  'Sides, what else would you use the space for?
 	function body;
}

Cheers!
Jon
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
