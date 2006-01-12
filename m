Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030334AbWALJCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030334AbWALJCf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 04:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030335AbWALJCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 04:02:34 -0500
Received: from nproxy.gmail.com ([64.233.182.196]:50634 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030334AbWALJCe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 04:02:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jbT2RA1eYOxUIcEnWI9LuOND+VTl/Fv8HxVyAWS8URT+lcLWcTc4LpSB94fMMP67L6GJVqsyqejB4XaIXKVytoIr08/L8J70TEhuj1KJwLqBLg9bZzWJqz3lyCbCeX6uVQYhKS7VqSQ9voCnu4sy3L/KMYe6DHXacT1ZNb5XJq8=
Message-ID: <84144f020601120102y78776487l2a1aea4e28a9dbb8@mail.gmail.com>
Date: Thu, 12 Jan 2006 11:02:29 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: [PATCH] pktcdvd & udf bugfixes
Cc: linux kernel <linux-kernel@vger.kernel.org>, axboe@suse.de
In-Reply-To: <43C5D71B.1060002@cfl.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43C5D71B.1060002@cfl.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/12/06, Phillip Susi <psusi@cfl.rr.com> wrote:
> Attached is a patch to fix a few bugs in the pktcdvd driver and udf
> filesystem.  Ben Collins said I should post it to the list and cc Jens
> Axboe as he works on this area.  The patch is rather short, but fixes
> the following bugs:

Please read Documentation/SubmittingPatches. The pktcdvd and UDF fixes
should be separate patches and you should cc the appropriate
maintainers which you can find in the MAINTAINERS file. Thanks.

                                         Pekka
