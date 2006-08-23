Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbWHWNBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbWHWNBZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 09:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbWHWNBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 09:01:25 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:32972 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932451AbWHWNBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 09:01:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iN08sod1N0ad1p5SikMO135SzqVeO4yBT/yLeX/sqimhsrh0Di+vUzDK1puf9OnwePV/+7W5MVSuLfkZAjEPYGaJL5QLuPQKhZm+kJ9O/TdN/FrgA/UtkGTpm+bSQM0U6k4V8y2HXOGGNv3ksSyeOuDdwPfYiWKAuRAdKt0aMRs=
Message-ID: <2c0942db0608230601h78d054b5td483e8669b97be20@mail.gmail.com>
Date: Wed, 23 Aug 2006 06:01:23 -0700
From: "Ray Lee" <madrabbit@gmail.com>
Reply-To: ray-gmail@madrabbit.org
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Subject: Re: Group limit for NFS exported file systems
Cc: "Robert Szentmihalyi" <robert.szentmihalyi@gmx.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0608231356180.14327@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060823091652.235230@gmx.net>
	 <2c0942db0608230355s74af2717g78675ea56b689fc0@mail.gmail.com>
	 <20060823111119.203710@gmx.net>
	 <2c0942db0608230435n1b680f11q3b19669f0bb62268@mail.gmail.com>
	 <Pine.LNX.4.61.0608231356180.14327@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/06, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> If only the client needs to be patched, non-patched and/or non-Linux
> clients and the server (linux or not) should have a problem, should they?

As I understand it, that's correct. Robert could legitimately patch
only the system(s) in use by the user with 27 groups.

Again, though, I haven't used it, so take that with a grain of salt.

~r.
