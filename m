Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262541AbVDPBVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262541AbVDPBVF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 21:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262545AbVDPBVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 21:21:05 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:61198 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S262541AbVDPBVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 21:21:01 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@taverner.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: Fortuna
Date: Sat, 16 Apr 2005 01:19:03 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <d3pp67$4m5$1@abraham.cs.berkeley.edu>
References: <20050414141538.3651.qmail@science.horizon.com> <20050414145204.GI12263@certainkey.com>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1113614343 4805 128.32.168.222 (16 Apr 2005 01:19:03 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Sat, 16 Apr 2005 01:19:03 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean-Luc Cooke  wrote:
>Info-theoretic randomness is a strong desire of some/many users, [..]

I don't know.  Most of the time that I've seen users say they want
information-theoretic randomness, I've gotten the impression that those
users didn't really understand what information-theoretic randomness means,
and their applications usually didn't need information-theoretic randomness
in the first place.

As for those who reject computational security because of its
unproven nature, they should perhaps be warned that any conjectured
information-theoretic security of /dev/random is also unproven.

Personally, I feel the issue of information-theoretic security
is a distraction.  Given the widespread confusion about what
information-theoretic security means, I certainly sympathize with why
Jean-Luc Cooke left in the existing entropy estimation technique as a
way of side-stepping the whole argument.

Anyway, the bottom line is I don't consider "information-theoretic
arguments" as a very convincing reason to reject Cooke's proposal.
