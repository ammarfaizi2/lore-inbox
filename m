Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262354AbSLPTVf>; Mon, 16 Dec 2002 14:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262631AbSLPTVf>; Mon, 16 Dec 2002 14:21:35 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:12328 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S262354AbSLPTVe>; Mon, 16 Dec 2002 14:21:34 -0500
To: Andy Pfiffer <andyp@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kexec for 2.5.52
References: <m1smwxapdp.fsf@frodo.biederman.org>
	<1040066196.2183.2.camel@andyp>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 16 Dec 2002 12:29:12 -0700
In-Reply-To: <1040066196.2183.2.camel@andyp>
Message-ID: <m1of7lahkn.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Pfiffer <andyp@osdl.org> writes:

> On Mon, 2002-12-16 at 08:40, Eric W. Biederman wrote:
> > Linus will you please apply this?
> 
> Eric,
> 
> The patch applied cleanly for me.
> 
> Is there a new kexec-tools package for this, or should the 1.8 rev
> located here:
> http://www.xmission.com/~ebiederm/files/kexec/
> work okay?

1.8 should work.
 
> Also, is there a separate hwfixes patch as before?

The old hwfixes should work as well.  If the .48 version does not
patch cleanly holler.

Eric
