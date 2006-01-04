Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965300AbWADWkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965300AbWADWkm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965303AbWADWkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:40:42 -0500
Received: from xproxy.gmail.com ([66.249.82.207]:4764 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965300AbWADWkl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:40:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lMD04cY3CI8Z/Yq9lNFbwTf5281FBzFLyawmfpp/qtVww981+os3DgaE54HPNjq8z7AwCvn2DdZ4YHcGSBEj5p2sWSBj5R+riObbiFmku2WOQJPgIC4DsvBL5NalVFTzdGHEH7TpE//KIj1R8LJsSfUMm+eGpcHQfPjbWzHe6Yg=
Message-ID: <4d8e3fd30601041440ja24b40em17848766e282cfef@mail.gmail.com>
Date: Wed, 4 Jan 2006 23:40:40 +0100
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Ben Collins <bcollins@ubuntu.com>
Subject: Re: [PATCH 0/15] Ubuntu patch sync
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
In-Reply-To: <0ISL003P992UCY@a34-mta01.direcway.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <0ISL003P992UCY@a34-mta01.direcway.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/06, Ben Collins <bcollins@ubuntu.com> wrote:
> These patches are just attempts to merge code from the ubuntu kernel tree.
> This is most of the differences between our tree and stock code (not
> necessarily all differences, since we do have a lot of external drivers
> pulled in).

Hi Ben,
Just a note in case you don't receive feedbacks to all the patches,
it looks like you didn't CC the relevant maintainers.

Anyway, i really appreciate that you try to keep as in sync as
possible the Ubuntu kernel to the vanilla.

Ciao,
--
Paolo
