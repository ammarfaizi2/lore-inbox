Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbVBNIcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbVBNIcX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 03:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbVBNIcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 03:32:22 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:61502 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261371AbVBNIcU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 03:32:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Ebn8/Ob8vWIZeR4/tA7K7/CX86yYBHgkkXFbfOE1skAR4Ua1rRGejuJl7cz1AqzIuTcRpys5BHzKuMQ/f86P0GZzXRf8jgpIS64/dnwQrbkk8i7EF9Qw2Jtlh7DkbOEmk1rs5qovdsKFhFS1+5R6ELEfao9vuHnS9EUD010w/wY=
Message-ID: <4d8e3fd305021400323fa01fff@mail.gmail.com>
Date: Mon, 14 Feb 2005 09:32:19 +0100
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Reply-To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [ANNOUNCE] hotplug-ng 001 release
Cc: Greg KH <gregkh@suse.de>, Patrick McFarland <pmcfarland@downeast.net>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <1108354011.25912.43.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050211004033.GA26624@suse.de> <420C054B.1070502@downeast.net>
	 <20050211011609.GA27176@suse.de>
	 <1108354011.25912.43.camel@krustophenia.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Feb 2005 23:06:51 -0500, Lee Revell <rlrevell@joe-job.com> wrote:
> On Thu, 2005-02-10 at 17:16 -0800, Greg KH wrote:
> > All distros are trying to reduce boot time.
> 
> They certainly aren't all trying very hard.  Debian and Fedora (last
> time I checked) do not even run the init scripts in parallel.

Is there any distro that is running the init scripts in parallel ?
-- 
Paolo <paolo dot ciarrocchi at gmail dot com>
msn: paolo407@hotmail.com
hello: ciarrop
