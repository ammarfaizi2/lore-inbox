Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932538AbWGSVgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538AbWGSVgq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 17:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbWGSVgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 17:36:46 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:15020 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S932538AbWGSVgq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 17:36:46 -0400
Message-ID: <44BEA5E0.1070105@cmu.edu>
Date: Wed, 19 Jul 2006 17:36:32 -0400
From: George Nychis <gnychis@cmu.edu>
User-Agent: Thunderbird 1.5.0.4 (X11/20060612)
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
CC: Brandon Philips <brandon@ifup.org>, lkml <linux-kernel@vger.kernel.org>,
       forrest.zhao@intel.com
Subject: Re: suspend/hibernate to work on thinkpad x60s?
References: <30DF6C25102A6E4BBD30B26C4EA1DCCC0162E099@MEMEXCH10V.corp.ds.fedex.com> <200607191742.32609.rjw@sisk.pl> <44BE5589.4070403@cmu.edu> <200607192102.17438.rjw@sisk.pl> <44BE8D7C.8070107@cmu.edu> <20060719202333.GA8705@plankton.ifup.org> <44BE9C22.9060209@cmu.edu> <44BECC6A.7020608@goop.org>
In-Reply-To: <44BECC6A.7020608@goop.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wow, you'd think [PATCH 1/6] in the subject would give it away... of
course it does, for everyone but me that is ;)

Thanks guys, that works great.

- George


Jeremy Fitzhardinge wrote:
> George Nychis wrote:
>> Is there only 1 patch file?  I only see the 1 patch file on the link you
>> sent me, i applied it cleanly to a 2.6.18-rc1-git7 kernel and i still
>> have the same problem
> 
> There are 6 patches in the series.
> 
>    J
> 
