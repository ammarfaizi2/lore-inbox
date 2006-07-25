Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbWGYS66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbWGYS66 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 14:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbWGYS66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 14:58:58 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:61104 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932445AbWGYS66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 14:58:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qB73eYaUM68tIW0o5TRxBYPS8a57B0hLQIXCz0BuZCS/5VpjNsupGzmQVXpTnVIi0ZRHXTFJ/Nilv8hkZw2AkpEKIb33652ntGCWGLiYrguV1ijTFsqlT2qjZn4K+CxKlpETl9Fpp+EIOGYbig71huxJFwFIjUltEBgfEDbtF70=
Message-ID: <f96157c40607251158x29f9632ey85d371a1a5a074b8@mail.gmail.com>
Date: Tue, 25 Jul 2006 20:58:56 +0200
From: "gmu 2k6" <gmu2006@gmail.com>
To: "Jens Axboe" <axboe@suse.de>
Subject: Re: Re: i686 hang on boot in userspace
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <f96157c40607250750n5aa08856jbe792b0e66fb814b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060725074107.GA4044@suse.de>
	 <f96157c40607250128h279d6df7n8e86381729b8aa97@mail.gmail.com>
	 <20060725080807.GF4044@suse.de>
	 <f96157c40607250217o1084b992u78083353032b9abc@mail.gmail.com>
	 <f96157c40607250220h13abfd6av2b532cae70745d2@mail.gmail.com>
	 <f96157c40607250235t4cdd76ffxfd6f95389d2ddbdc@mail.gmail.com>
	 <20060725112955.GR4044@suse.de>
	 <f96157c40607250547m5af37b4gbab72a2764e7cb7c@mail.gmail.com>
	 <20060725125201.GT4044@suse.de>
	 <f96157c40607250750n5aa08856jbe792b0e66fb814b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thanks Jens,
7b30f09245d0e6868819b946b2f6879e5d3d106b
http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=7b30f09245d0e6868819b946b2f6879e5d3d106b
has fixed the problem (maybe together with the other 3 changes in HEAD
as the 2nd patch in this thread did not work in the first place or maybe
it is a little bit different, no time to check right now).
