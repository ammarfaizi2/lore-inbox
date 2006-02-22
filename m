Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWBVVS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWBVVS0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 16:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWBVVS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 16:18:26 -0500
Received: from uproxy.gmail.com ([66.249.92.193]:45495 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751139AbWBVVSZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 16:18:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=Gscap5LxQ1MLiwIuMVEdFr8YmzzIfTeaaDwc9UicgNvlQliEcSmv5y4iBqWc8PljXNO+mLiJNA+I/f2LSGgZ7tdk3arLU0S1PZ8qxIEUBgXt1KkCluKe7tI2cNkcNaCteYkahnqhrKUhLP15qTtdi7hCIM7OiMHyvojZR76J5BU=
Date: Wed, 22 Feb 2006 22:18:17 +0100
From: Frederik Deweerdt <deweerdt@free.fr>
To: Emmanuel Pacaud <emmanuel.pacaud@univ-poitiers.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: isolcpus weirdness
Message-ID: <20060222211817.GA13488@silenus.home.res>
References: <1140614487.13155.20.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140614487.13155.20.camel@localhost.localdomain>
User-Agent: mutt-ng/devel-r781 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 02:21:27PM +0100, Emmanuel Pacaud wrote:
> What's wrong ?
> 
Are you able to reproduce the same behaviour after disabling HT in
the kernel config? Also, could you post your .config?
Regards,
Frederik
