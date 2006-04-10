Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbWDJISA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbWDJISA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 04:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbWDJISA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 04:18:00 -0400
Received: from pproxy.gmail.com ([64.233.166.180]:50091 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751076AbWDJIR7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 04:17:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ajMksJUVdJ5TVRT62Dd8r3405g858cfJQjEk1GMKFbqKvaiezytwHbEq0R2RJQF9V2jZKdg1hW65tkIqReN1oPRu7pJBu3XLzltoMqbgloggTlxFDkW0x6UmhTsmLdUBxDkSDJ86oaqRrHE8To9hJsaElWlLhjLpLBiaeN1wk/8=
Message-ID: <3fe1d240604100117v2f686592kd92bb7967d7d5f51@mail.gmail.com>
Date: Mon, 10 Apr 2006 16:17:56 +0800
From: HuaFeijun <hua.feijun@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: hugetlb_page in 2.6.12
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there no the file  /proc/sys/vm/nr_hugepages in 2.6.12? And which
is the function has the same function as
register_profile_notifier,profile_event_register or 
task_handoff_register. If none of the two functions,what is the
function on earth?
