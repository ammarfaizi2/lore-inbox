Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751016AbWEEHUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbWEEHUk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 03:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbWEEHUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 03:20:40 -0400
Received: from wx-out-0102.google.com ([66.249.82.203]:8003 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751014AbWEEHUk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 03:20:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Ivzd6Xwh6zflWFZfTo08pwDglYfm5j8KSFdDsGNZXQOIDxmSi+ltgwKECeeN1dtAICYqk0x9dms4yB+Nqv7wIhPmes4YJjUUGPt5fzLthiumPErHAjqK8GEpGRJOrxxycpv4ngDHDez/8DdbRinm/DY7nDjzXxAxaK+Aa4JUjjI=
Message-ID: <7a37e95e0605050020x3b355e6cqdc6a59befb35d8d3@mail.gmail.com>
Date: Fri, 5 May 2006 12:50:39 +0530
From: "Deven Balani" <devenbalani@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Buffering Models
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All

I am working on Real-time streaming Applications, which is using
various Buffer Models, Can any one help in understanding the exact
_scenario_ to use these flow control mechanisms,

1) Circular Buffer.
2) Low Water Mark Mechanism with DMA.
3) Ping Pong Handshake. (or) Double Buffering.

Or please direct me a source.

Thanks,
Deven
