Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132940AbRDXJ7y>; Tue, 24 Apr 2001 05:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132959AbRDXJ7o>; Tue, 24 Apr 2001 05:59:44 -0400
Received: from t2.redhat.com ([199.183.24.243]:28142 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S132940AbRDXJ7c>; Tue, 24 Apr 2001 05:59:32 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.GSO.4.21.0104232241130.4968-100000@weyl.math.psu.edu> 
In-Reply-To: <Pine.GSO.4.21.0104232241130.4968-100000@weyl.math.psu.edu> 
To: Alexander Viro <viro@math.psu.edu>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Christoph Rohland <cr@sap.com>,
        "David L. Parsley" <parsley@linuxjedi.org>,
        linux-kernel@vger.kernel.org
Subject: Re: hundreds of mount --bind mountpoints? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 24 Apr 2001 10:58:08 +0100
Message-ID: <27577.988106288@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


viro@math.psu.edu said:
>  Oh, for crying out loud. All it takes is half an hour per filesystem.

Half an hour? If it takes more than about 5 minutes for JFFS2 I'd be very
surprised.

--
dwmw2


