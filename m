Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbWAXOg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWAXOg5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 09:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbWAXOg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 09:36:57 -0500
Received: from uproxy.gmail.com ([66.249.92.192]:48222 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932318AbWAXOgy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 09:36:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k6dlIgHLH5EAiOx8jIiqbSECdbI+Z2cV0qg614dcxbw7p/JA8wx/ilJpS6AvC4HUVPpB8QW8HbR1l+NmkfDlYYmucJ8ceaRK3TFNC/7MGlhuc9VVl/s4axqslIjfcWJ9VewOWOO7AlnVOud5pCvo31aMt50v8bepuTAvneBxusk=
Message-ID: <728201270601240636p58fead78m781fb104c3d73da9@mail.gmail.com>
Date: Tue, 24 Jan 2006 08:36:50 -0600
From: Ram Gupta <ram.gupta5@gmail.com>
To: Nikita Danilov <nikita@clusterfs.com>
Subject: Re: [RFC] VM: I have a dream...
Cc: Michael Loftis <mloftis@wgops.com>, "Barry K. Nathan" <barryn@pobox.com>,
       Al Boldi <a1426z@gawab.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <17365.23510.525066.57628@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200601212108.41269.a1426z@gawab.com>
	 <986ed62e0601221155x6a57e353vf14db02cc219c09@mail.gmail.com>
	 <E3C35184F807ADEC2AD9E182@dhcp-2-206.wgops.com>
	 <728201270601230705k25e6890ejd716dbfc393208b8@mail.gmail.com>
	 <280A351A008C409CEF43A734@dhcp-2-206.wgops.com>
	 <17365.23510.525066.57628@gargle.gargle.HOWL>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/06, Nikita Danilov <nikita@clusterfs.com> wrote:

>
> The unique feature that Mac OS X VM does have, on the other hand, is
> that it keeps profiles of access patterns of applications, and stores
> then in files, associated with executables. This allows to quickly
> pre-fault necessary pages during application startup (and this makes OSX
> boot so fast).

This feature is interesting though I am not sure about the fast boot
part of OSX.
as at boot time these applications are all started first time. So
there were no access pattern as yet. They still have to be demand
paged. But yes later accesses may be faster.

Thanks
Ram gupta
