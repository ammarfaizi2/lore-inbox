Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262128AbUK3Pcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbUK3Pcr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 10:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbUK3Pcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 10:32:47 -0500
Received: from psych.st-and.ac.uk ([138.251.11.1]:6814 "EHLO
	psych.st-andrews.ac.uk") by vger.kernel.org with ESMTP
	id S262128AbUK3Pcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 10:32:36 -0500
Subject: Re: file as a directory
From: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Christian Mayrhuber <christian.mayrhuber@gmx.net>,
       reiserfs-list@namesys.com, Hans Reiser <reiser@namesys.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200411301451.iAUEptDH006868@laptop11.inf.utfsm.cl>
References: <200411301451.iAUEptDH006868@laptop11.inf.utfsm.cl>
Content-Type: text/plain
Message-Id: <1101828580.17826.165.camel@pear.st-and.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 30 Nov 2004 15:29:40 +0000
Content-Transfer-Encoding: 7bit
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-30 at 14:51, Horst von Brand wrote:
> > I was suggesting this idea mainly form XML files, where the tags define 
> > the parts clearly.
> 
> Use a XML parsing library then.

But namespace unification is important, and to unify the namespace, you
have to use the same syntax. I guess you disagree with me on that. (If
not, how would you do it?)  Peter


