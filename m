Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266981AbUBMMmO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 07:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266982AbUBMMmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 07:42:14 -0500
Received: from mail.aei.ca ([206.123.6.14]:44756 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S266981AbUBMMmL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 07:42:11 -0500
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH, RFC: 2.6 Documentation/Codingstyle
Date: Fri, 13 Feb 2004 07:42:08 -0500
User-Agent: KMail/1.5.93
Cc: Andries Brouwer <aebr@win.tue.nl>
References: <200402130615.10608.mhf@linuxmail.org> <XFMail.20040213095802.pochini@shiny.it> <20040213124232.B2871@pclin040.win.tue.nl>
In-Reply-To: <20040213124232.B2871@pclin040.win.tue.nl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402130742.08853.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 13, 2004 06:42 am, Andries Brouwer wrote:
> On Fri, Feb 13, 2004 at 09:58:02AM +0100, Giuliano Pochini wrote:
> >> +The limit on the length of lines is 80 columns and this is a hard
> >> limit.
> >
> > Well, I think this requirement is a bit silly IMHO. How many of us
> > do usually code in a 80x25 terminal screen nowadays ?
>
> I do. (That is, 80xN with N in 24..60 or so.)
>
> The 80 here has a pedagogical and a practical purpose.
> The practical one is that it makes sure that everybody can read the source.
> The pedagogical is to invite you to arrange the code in a different way
> if you are nesting too deeply or your expressions are too complicated.
>
> There is also ergonomics. There is a reason newspapers do not print
> text across the full width of the page - it would be very difficult
> to read. There is an optimal column width. One might fight over the
> exact value of the optimum, but 80 columns is not a bad choice.

This would be true if not for indenting.  A program is not a newspaper.
I doubt the lenght of text, excluding the indent is longer than 80 chars
very often....   With 80 columns and indenting code looks ugly.

Ed Tomlinson
