Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750904AbWEQOqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbWEQOqu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 10:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbWEQOqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 10:46:50 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:37131 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750735AbWEQOqt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 10:46:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=XFh/YdMM8dgPJ+0FXNtfmj2AfT7ZTkeQG9XG+3rFp4AlUxwuZ6c1T4tCR36NimdQlnyCQzqmXTX0CQuIeRa6ma96vOcaWISUwFKiawBQMXIlPIoFNVeSUzpoTmzYMYDtbjNq3ExBBQ54ZNw8qX+gmrM/c2RfAx2k7DvM08JdWck=
Message-ID: <b6c5339f0605170746u10fb7c32y8b8526feb9c9528b@mail.gmail.com>
Date: Wed, 17 May 2006 10:46:48 -0400
From: "Bob Copeland" <me@bobcopeland.com>
To: "Olivier Galibert" <galibert@pobox.com>,
       "Panagiotis Issaris" <takis@lumumba.uhasselt.be>,
       Valdis.Kletnieks@vt.edu, "linux cbon" <linuxcbon@yahoo.fr>,
       linux-kernel@vger.kernel.org
Subject: Re: replacing X Window System !
In-Reply-To: <20060517142338.GB54677@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060517123937.75295.qmail@web26605.mail.ukl.yahoo.com>
	 <200605171319.k4HDJwhv015404@turing-police.cc.vt.edu>
	 <446B2EDE.7060000@lumumba.uhasselt.be>
	 <20060517142338.GB54677@dspnet.fr.eu.org>
X-Google-Sender-Auth: 52a832c9a38721a3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/06, Olivier Galibert <galibert@pobox.com> wrote:
> So in practice it is a better idea to have a libX11-compatible API
> (and if possible ABI), which will give you gdk/gtk/Qt/Motif for "free"
> (not GL/SDL though), and then change gtk/Qt where appropriate to use
> your own features.

If only there was a way to get all of that for free without doing any
work at all :)

Bob
