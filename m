Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752106AbWJXHlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106AbWJXHlN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 03:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752107AbWJXHlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 03:41:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:25935 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1752106AbWJXHlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 03:41:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=EPG0xP+HgECPN+d9D6fjTQ4wUDuiM8MyAz0CxT39J5PzjF15PBp92SG3GHIm4PzRYrXeSKg1hAtEXhtUvzu+HnMdJqZUD0TvZJbWRrp0Wi/l6niAgSCB57IdtkbJ4FGPhNdPja4j/qknUOWUFJB+YBX4AWIud5G2TGSaujugpPs=
Message-ID: <84144f020610240041u4aea2209ncd90a45f355fe315@mail.gmail.com>
Date: Tue, 24 Oct 2006 10:41:09 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: Mitch <Mitch@0bits.com>
Subject: Re: More uml build failures on 2.16.19-rc3 and 2.6.18.1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <453DC147.2020508@0Bits.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <453DC147.2020508@0Bits.COM>
X-Google-Sender-Auth: aeeec85690f8592d
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/06, Mitch <Mitch@0bits.com> wrote:
> I'm still having build failures on 2.6.18.1 and even the latest -rc3

Did you remember to do make mrproper? If yes, can we have your .config, please.
