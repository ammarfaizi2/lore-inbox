Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbTHYJYH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 05:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbTHYJYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 05:24:07 -0400
Received: from main.gmane.org ([80.91.224.249]:11664 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261596AbTHYJYC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 05:24:02 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [PATCH]O18.1int
Date: Mon, 25 Aug 2003 11:24:01 +0200
Message-ID: <yw1xr83accpa.fsf@users.sourceforge.net>
References: <200308231555.24530.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:BIXafDOtFR9rOK6/oLV2nEeXbmM=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


XEmacs still spins after running a background job like make or grep.
It's fine if I reverse patch-O16.2-O16.3. The spinning doesn't happen
as often, or as long time as with O16.3, but it's there and it's
irritating.

-- 
Måns Rullgård
mru@users.sf.net

