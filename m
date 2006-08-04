Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161572AbWHDXEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161572AbWHDXEm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 19:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161574AbWHDXEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 19:04:42 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:28503 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161572AbWHDXEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 19:04:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=J8pLxqltBLTPzAc9fTIjmFFe0Fz2kUo8ACrXZJyczFVRYRKV78+plaVQ6ZKAoiUqC52JX1yzhAtS0QDJyrj+ZZExv2451lWd7o3DI6hEyJyEuCqJyQxnqWrjepEi3Ul8jXXp1M+zsSSIAwQXHIJFXq/V+h4rg9F016TWSZie3iU=
Message-ID: <44D3D299.3010607@gmail.com>
Date: Sat, 05 Aug 2006 01:04:34 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: =?ISO-8859-1?Q?=22J=2EA=2E_Magall=F3n=22?= <jamagallon@ono.com>,
       "Linux-Kernel, " <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.6.18-rc2-mm1] libata cdroms not automounted
References: <20060803011633.13338417@werewolf.auna.net> <44D2F744.70302@gmail.com>
In-Reply-To: <44D2F744.70302@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> polling for SCSI cdroms for that reason.  I seem to recollect the 
> polling was done by some gnome daemon, not sure which though.

probably gnome-volume-manager

regards,
-- 
<a href="http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
