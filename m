Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266944AbUBMLmm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 06:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266947AbUBMLmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 06:42:42 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:531 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S266944AbUBMLml (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 06:42:41 -0500
Date: Fri, 13 Feb 2004 12:42:32 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Giuliano Pochini <pochini@shiny.it>
Cc: Michael Frank <mhf@linuxmail.org>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH, RFC: 2.6 Documentation/Codingstyle
Message-ID: <20040213124232.B2871@pclin040.win.tue.nl>
References: <200402130615.10608.mhf@linuxmail.org> <XFMail.20040213095802.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <XFMail.20040213095802.pochini@shiny.it>; from pochini@shiny.it on Fri, Feb 13, 2004 at 09:58:02AM +0100
X-Spam-DCC: servers: mailhost.tue.nl 1049; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 13, 2004 at 09:58:02AM +0100, Giuliano Pochini wrote:

>> +The limit on the length of lines is 80 columns and this is a hard limit.
> 
> Well, I think this requirement is a bit silly IMHO. How many of us
> do usually code in a 80x25 terminal screen nowadays ?

I do. (That is, 80xN with N in 24..60 or so.)

The 80 here has a pedagogical and a practical purpose.
The practical one is that it makes sure that everybody can read the source.
The pedagogical is to invite you to arrange the code in a different way
if you are nesting too deeply or your expressions are too complicated.

There is also ergonomics. There is a reason newspapers do not print
text across the full width of the page - it would be very difficult
to read. There is an optimal column width. One might fight over the
exact value of the optimum, but 80 columns is not a bad choice.

Andries
