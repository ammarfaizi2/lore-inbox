Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264129AbUG2EMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264129AbUG2EMa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 00:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264192AbUG2EM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 00:12:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61831 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264129AbUG2EMW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 00:12:22 -0400
Message-ID: <410878AE.2050805@redhat.com>
Date: Wed, 28 Jul 2004 21:10:22 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040728
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: davem@redhat.com, peter@chubb.wattle.id.au,
       viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: stat very inefficient
References: <233602095@toto.iv>	<16648.10711.200049.616183@wombat.chubb.wattle.id.au>	<20040728154523.20713ef1.davem@redhat.com>	<41084DBE.1070802@redhat.com> <20040728192252.42a078a3.pj@sgi.com>
In-Reply-To: <20040728192252.42a078a3.pj@sgi.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:

> Ulrich - could you provide a clue where to find a find that does what
> you describe?

If I claim to see this behavior you could have guessed that at least Red
Hat releases have this feature enabled.  If you unpack the .src.rpm
you'll see a file findutils-d_type.patch.  There have been attempts to
get the patch upstream but they failed.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
