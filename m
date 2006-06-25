Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbWFYUJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWFYUJM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 16:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWFYUJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 16:09:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:40991 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932239AbWFYUJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 16:09:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Lgbvr8L5vhsxZwXICCZldh5SAeeToCcaM3XlCuXVPpfTnPBELwrXtLS1jw4rPy11IESuLw8dLAsZYdDX9mla83WEq31COaJUNtGu+GJnOLwfGpAoH2pyd3n0hwfLAOvyFDr+keIEyDrVUI0nkli6kMGlMwmUzWLQRQlydia1nJM=
Message-ID: <bda6d13a0606251309x3e07e9feoad777d9a062f923f@mail.gmail.com>
Date: Sun, 25 Jun 2006 13:09:09 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernelsources writeable for everyone?!
In-Reply-To: <449E216E.8010508@sbcglobal.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200606242000.51024.damage@rooties.de>
	 <20060624181702.GG27946@ftp.linux.org.uk>
	 <1151198452.6508.10.camel@mjollnir> <449E216E.8010508@sbcglobal.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I feel like asking how they initially get set to world-writable. To me
it means that the tree that is being tarred up for distribution is
world-writible. I sure hope that it is a single-user box.
