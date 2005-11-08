Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030363AbVKHVUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030363AbVKHVUK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 16:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030365AbVKHVUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 16:20:10 -0500
Received: from xproxy.gmail.com ([66.249.82.195]:65105 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030363AbVKHVUI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 16:20:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=AS09txj+CkojqpW/JAq1deAM7Yq1pAFQX9oIAxTSS3kx0lbSPd9kYd1jJQwulP7WzJzxiM/Ege80ZmEyYSQ9CZBUHA/kM3EsdDAw/TMzG+5jgGcvppFCcvVJhk2475qQpIRsO6dOpV+NmXFSjtHSsf91jXRAVS6mNQPt9E/I3iU=
Subject: Re: Creating new System.map with modules symbol info
From: Chris Largret <largret@gmail.com>
To: Adayadil Thomas <adayadil.thomas@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <fb7befa20511081304sec70208l5d1a464e5af78f58@mail.gmail.com>
References: <fb7befa20511081304sec70208l5d1a464e5af78f58@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 08 Nov 2005 13:19:47 -0800
Message-Id: <1131484787.5520.3.camel@shogun.daga.dyndns.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 Dropline GNOME 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-08 at 16:04 -0500, Adayadil Thomas wrote:
> Greetings.
> 
> The System map that was created when compiling kernel does'nt have the symbols
> of modules that are loaded later. How can I create a new System.map
> with the symbols of
> modules also.

>From the linux kernel source directory, take a look at scripts/mksysmap.

--
Chris Largret <http://daga.dyndns.org>

