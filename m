Return-Path: <linux-kernel-owner+w=401wt.eu-S965009AbWLTMhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbWLTMhY (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 07:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965011AbWLTMhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 07:37:24 -0500
Received: from wx-out-0506.google.com ([66.249.82.226]:56792 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965009AbWLTMhX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 07:37:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ny1kbrxtpyZb5aiSoJDd3517PErzdfP1EIsw3i1039MtH5rsofZXDcOz+Y0rmzgZd+x5zMhWyTwF7V+iK8CGfgLKU2jJjgHF5vy7oiz5dT5asK3+jWlpnYazYgB5FTwmQ8Cp7NZbaPm9buTpBddajoWQIaRB57Zr1rTSOtG1TVk=
Message-ID: <e6babb600612200437n6c5ff4d4lf86e60c309dd1b6e@mail.gmail.com>
Date: Wed, 20 Dec 2006 05:37:23 -0700
From: "Robert Crocombe" <rcrocomb@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.19.1-rt15: BUG in __tasklet_action at kernel/softirq.c:568
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20061219175728.GA20262@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e6babb600612180948n7820c038k148a5a514d541b2e@mail.gmail.com>
	 <20061219175728.GA20262@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/06, Ingo Molnar <mingo@elte.hu> wrote:
> yeah. This is something that triggers very rarely on certain boxes. Not
> fixed yet, and it's been around for some time.

Is there anything you would like me to do to help diagnose this?

-- 
Robert Crocombe
rcrocomb@gmail.com
