Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbTJGNsR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 09:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbTJGNsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 09:48:17 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:7500 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id S262224AbTJGNsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 09:48:13 -0400
Date: Tue, 7 Oct 2003 06:48:09 -0700 (PDT)
From: Tigran Aivazian <tigran@veritas.com>
To: "Giacomo A. Catenazzi" <cate@debian.org>
cc: linux-kernel@vger.kernel.org, <simon@urbanmyth.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: RFC: changes to microcode update driver.
In-Reply-To: <3F82C0EF.1040002@debian.org>
Message-ID: <Pine.GSO.4.44.0310070639580.18079-100000@south.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Oct 2003, Giacomo A. Catenazzi wrote:
> Is microcode_ctl still maintained? I've made some correction/extentions but now
> new from the maintainer.

Yes, I believe Simon is alive and well. (but busy, as we all are)

> Intel give us the new microcode? I had contact with the new contact/maintainer/?
> person in Intel, but still no new microcode since summer 2001. So maybe before
> changing the driver, could you check the Intel vision about Linux and microcode?

I am communicating with Intel guys from time to time and there are some
interesting changes from Intel in the pipeline to update the driver, but I
thought it is worthwhile to cleanup and throw away unnecessary bits before
applying a major update (otherwise we would be wasting time debugging an
update to code which is no longer needed).

As for the microcode data itself, no, I haven't received anything new from
Intel yet but please be patient. I have received unofficial latest
"hacked"  version of microcode data from someone (outside Intel) but it
will not be uploaded because it will cause support problems both to Intel
and myself.

I find it is wiser to be friendly with Intel than to annoy them with
constant questions "where is the latest microcode data" :)

Kind regards
Tigran





