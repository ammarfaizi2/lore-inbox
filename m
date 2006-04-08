Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964876AbWDHLHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbWDHLHM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 07:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964900AbWDHLHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 07:07:12 -0400
Received: from wproxy.gmail.com ([64.233.184.224]:22334 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964876AbWDHLHK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 07:07:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FYI+lEFxO+LtKziiVINsyOY8b7Fw8/XAdFuC6bRGerGYh9mWZNanlie3vr2ntddghckzOt3fv3iLiophg35kAp505BWBiBac/T49EGwE6Pk2hWFHJEayzQaLfTcoz4Th2LM3KGUtuslG5Hie2i5fN+IvOv1EAAnaGCkBe6myOI4=
Message-ID: <e5bfff550604080407g7606d515qec566f83e0e2d7cb@mail.gmail.com>
Date: Sat, 8 Apr 2006 13:07:09 +0200
From: "Marco Costalba" <mcostalba@gmail.com>
To: git@vger.kernel.org
Subject: Re: [ANNOUNCE] qgit-1.2rc1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <e5bfff550604080244y40b36292ja5cfecac28e1e749@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <e5bfff550604080244y40b36292ja5cfecac28e1e749@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/06, Marco Costalba <mcostalba@gmail.com> wrote:
> qgit is a very fast git GUI viewer with a lot of features .
>
> The biggest new feature this time is *code range filtering*
>

Before hitting the warning pop-up about git version compatibility at
qgit launch,please note that a git with --boundary option support
is required.

git-rev-list --boundary has been merged after git-1.3.0.rc1, so better
upgrade git to latest upstream snapshot git-1.3.0rc3

Of course final qgit-1.2 will be out only _after_  released git-1.3.0

    Marco
