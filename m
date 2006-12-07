Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032312AbWLGPdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032312AbWLGPdM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 10:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032313AbWLGPdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 10:33:12 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:6319 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032312AbWLGPdK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 10:33:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HC4d7yvCgkX6Dg0QPCe5pxEL0HS+b4J65vd3xCr6j5zx4vrD16KaKIVfniaN2bvykL//ENphvBoVCjX+GOh4cDKuZ5pg8YHcao4TpDI6tcfYhyo9te0qXiq0mxUIQv1hqhWWkfr6+rKhqkJo/zIBRI9nRpDq2t6UPcuK++O9+sA=
Message-ID: <a36005b50612070733t7d1ccdcej86165012d15298b@mail.gmail.com>
Date: Thu, 7 Dec 2006 07:33:08 -0800
From: "Ulrich Drepper" <drepper@gmail.com>
To: "Andreas Schwab" <schwab@suse.de>
Subject: Re: Linux should define ENOTSUP
Cc: "Theodore Tso" <tytso@mit.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <jezm9zaid2.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061206135134.GJ3927@implementation.labri.fr>
	 <1165415115.3233.449.camel@laptopd505.fenrus.org>
	 <20061206143159.GP3927@implementation.labri.fr>
	 <20061207134914.GB31773@thunk.org> <je7ix3bycr.fsf@sykes.suse.de>
	 <20061207141542.GD31773@thunk.org> <jezm9zaid2.fsf@sykes.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/06, Andreas Schwab <schwab@suse.de> wrote:
> The quoted sentence is not shaded as an XSI extension, thus it is part of
> POSIX-1:2001.

Perhaps I didn't make myself clear.  The change I pointed at was
accepted to the interpretations track which means that if we would
create a Technical Corrigendum 3 for the 2001 standard (which we are
not) the relaxation for the error values would be added.  The current
situation is just as good, it's just as binding.  There is no need to
reissue the standard to make such changes.

So, put this issue to rest.  There is not issue.  The whole premise
for the original post is wrong these days.  There is no compliance
problem.
