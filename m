Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262612AbVF2U1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262612AbVF2U1g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 16:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbVF2U1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 16:27:36 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:34104 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262612AbVF2U1f convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 16:27:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mxY/l7cTPyVWObCvTKNqV73ETBbgvl7GZ5AIBFPr+6aYMZz6kM2aURdSs7zIHKXsep1eRV/rzMpba0/RewZL9O3hSjJtvZS6YON/VXkzN1THFNKF5oofNz3cjhJR192ti3J8u3t240NnDAnrsOEd+nj2qltq6MWA+uDAsQrBwYE=
Message-ID: <94e67edf05062913272899af73@mail.gmail.com>
Date: Wed, 29 Jun 2005 16:27:34 -0400
From: Sreeni <sreeni.pulichi@gmail.com>
Reply-To: Sreeni <sreeni.pulichi@gmail.com>
To: linux-os@analogic.com, linux-kernel@vger.kernel.org
Subject: Forcing loader to load a prog at a fixed memory location
In-Reply-To: <17090.65093.315260.889211@smtp.charter.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <94e67edf05062810586d6141f3@mail.gmail.com>
	 <m1br5p3ib8.fsf@ebiederm.dsl.xmission.com>
	 <94e67edf050629083745bb4183@mail.gmail.com>
	 <Pine.LNX.4.61.0506291245170.22243@chaos.analogic.com>
	 <17090.65093.315260.889211@smtp.charter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

May I know the possible ways of instrcuting the compiler/loader to
place a process's 'data segments (data, stack, heap bss etc)' at a
*fixed*  physical/virtual addresses?

Thanks
Sreeni
