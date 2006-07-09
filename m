Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbWGIJpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbWGIJpJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 05:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWGIJpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 05:45:08 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:62045 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751318AbWGIJpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 05:45:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m8cOGAf90MyFEjILZ/v+syoGAQhE4XlqRSKXgCOJ04fLTPuiLVtBxJrUkFSifExzQdwUe7pg3TDeW4tZsG4pFQSYX8EtYp+LMr9Uf20uI+6BItY53WO7FJPExQHA/eNVkGckr5d3fHr9fTZzzkEtHpz6LDqXOiBzHzR5tIdJynM=
Message-ID: <6bffcb0e0607090245t2dbcd394n86ce91eec661f215@mail.gmail.com>
Date: Sun, 9 Jul 2006 11:45:06 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Daniel Bonekeeper" <thehazard@gmail.com>
Subject: Re: Automatic Kernel Bug Report
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <e1e1d5f40607090145k365c0009ia3448d71290154c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e1e1d5f40607090145k365c0009ia3448d71290154c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 09/07/06, Daniel Bonekeeper <thehazard@gmail.com> wrote:
> Well this probably was already discussed. Some distros have automatic
> bug reporting tools that are triggered when something bad happens
> (don't know if includes kernel stuff). But have anybody thought about
> some kind of bug report tool that, under an Oops like a NULL point
> dereference, it creates for example a packed file with the config used
> to build the kernel, the kernel version, loaded modules, some hardware
> info, backtraces, everything that could be useful for debugging, and
> sends to a server to be catalogued ?

How about oops reporting tool?
http://www.stardust.webpages.pl/files/ort/

[snip]
>
> Wouldn't that be helpful ?
>
> Daniel
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
