Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWCSPTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWCSPTi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 10:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbWCSPTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 10:19:37 -0500
Received: from nproxy.gmail.com ([64.233.182.202]:18139 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932109AbWCSPTh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 10:19:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GiJCbGwtzDgy2Ga1BCn8Osc5KB7Hkpe4+qiR1D5d2ghAszZ13ruP5zyJHUQltUgeKwz0XXi6YBNlm+mI4dGk+GxVcHmGs3S3weIRXcS6S0MKw3xTfvfHhFC/OnTeZn3oM8LAqWFh6gy/OXToeHLEWh+7eIOQCm9XXlu3d4EuVrY=
Message-ID: <b6c5339f0603190719u6e52ba3cwda15509de3ed947e@mail.gmail.com>
Date: Sun, 19 Mar 2006 10:19:31 -0500
From: "Bob Copeland" <me@bobcopeland.com>
To: "Benjamin Bach" <benjamin@overtag.dk>
Subject: Re: Idea: Automatic binary driver compiling system
Cc: "Arjan van de Ven" <arjan@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <441D36DA.2000701@overtag.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <441AF93C.6040407@overtag.dk> <1142620509.25258.53.camel@mindpipe>
	 <441C213A.3000404@overtag.dk>
	 <1142694655.2889.22.camel@laptopd505.fenrus.org>
	 <441C2CF6.1050607@overtag.dk>
	 <1142698292.2889.26.camel@laptopd505.fenrus.org>
	 <441D36DA.2000701@overtag.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Anyways, I'm very happy with the combination of intelligence and
> idealism on this list, and suddenly I feel more attracted to writing a
> driver instead. For my Rio Karma mp3 player. It's a USB thing.. should
> be do-able in 3 months even though I've never written a driver.
>

I've already done this and it is in 2.6.16.  There's still some work
to be done on the filesystem; check out
http://linux-karma.sourceforge.net to help out.

-Bob
