Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751557AbWE0P3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557AbWE0P3A (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 11:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbWE0P3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 11:29:00 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:63923 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751556AbWE0P26 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 11:28:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ELGgKwqKC+wzlI2dydpY8j7mF+D3pKjRslWkNHVWRoJ5nSfhhmwvKuXFMZixXxGo+BAFzJ+/XoNK6mhg4tSkx6Ziix7lexp+SVtfi3WzvajZx8h8KElYENQDKiwx0p38WsqGUj4LGrTAxKd1u0RLNnuCjrMXogGiavFm0GdhXpo=
Message-ID: <46a038f90605270828u7842ea48hda07331388694db2@mail.gmail.com>
Date: Sun, 28 May 2006 03:28:57 +1200
From: "Martin Langhoff" <martin.langhoff@gmail.com>
To: "Jeff Garzik" <jeff@garzik.org>
Subject: Re: [SCRIPT] chomp: trim trailing whitespace
Cc: "Git Mailing List" <git@vger.kernel.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <4477B905.9090806@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4477B905.9090806@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I love perl golf for this kind of stuff... but git-stripspace is part
of git already. Even then, I tend to do it with perl -pi -e ''
constructs ;-)

cheers,


m
